defmodule ShopWeb.Api.OrdersController do
  use ShopWeb, :controller
  @moduledoc false

  #   import Plug.Conn
  alias Shop.Orders
  alias Shop.Helpers.Helper

  def make_order(
        conn,
        %{
          "phone" => phone,
          "amount" => amount
        } = order_params
      ) do
    code = Helper.randomizer(5)

    order_params =
      Map.merge(order_params, %{
        "code" => code
      })

    case Orders.validate_order(order_params) do
      %Ecto.Changeset{valid?: true} ->
        case Mpesa.make_request(amount, "254" <> String.slice(phone, -9, 9), "Phx Shop", code) do
          {:ok, response} ->
            Map.merge(order_params, %{
              "CheckoutRequestID" => response["CheckoutRequestID"],
              "MerchantRequestID" => response["MerchantRequestID"]
            })

            ConCache.put(:orders_cache, response["CheckoutRequestID"], order_params)

            conn
            |> put_status(200)
            |> json(%{code: response["CheckoutRequestID"], message: "Payment Initiated"})

          {:error, message} ->
            conn
            |> put_status(403)
            |> json(%{message: message})
        end

      %Ecto.Changeset{valid?: false} = changeset ->
        errors = Ecto.Changeset.traverse_errors(changeset, &translate_error/1)

        conn
        |> put_status(422)
        |> json(%{errors: errors})
    end
  end

  def payment_response(conn, %{"Body" => %{"stkCallback" => stkCallback}} = _response) do
    # IO.inspect(Enum.at(stkCallback["CallbackMetadata"]["Item"], 0)["Value"])
    # IO.inspect(stkCallback["CheckoutRequestID"])

    if(stkCallback["ResultCode"] === 0) do
      order = ConCache.get(:orders_cache, stkCallback["CheckoutRequestID"])

      if(order) do
        transaction = %Shop.Orders.Transaction{
          merchant_requeuest: stkCallback["MerchantRequestID"],
          checkout_request: stkCallback["CheckoutRequestID"],
          mpesa_receipt_no: Enum.at(stkCallback["CallbackMetadata"]["Item"], 1)["Value"],
          amount: Enum.at(stkCallback["CallbackMetadata"]["Item"], 0)["Value"],
          phone: Enum.at(stkCallback["CallbackMetadata"]["Item"], 4)["Value"]
        }

        order =
          Map.merge(order, %{
            "transaction" => transaction
          })

        case Orders.create_order(order) do
          {:ok, _order} ->
            ConCache.delete(:orders_cache, stkCallback["CheckoutRequestID"])
            conn
            |> text('Success')

          {:error, _error} ->
            conn |> text('Error 1, failed creating')
        end
      else
        conn |> text('Error 3, No Order')
      end
    else
      conn |> text('Error 2, Wrong response')
    end
  end
end
