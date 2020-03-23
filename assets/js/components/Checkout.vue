<template>
	<form action id method="post">
		<div class="row">
			<div class="col-md-12">
				<span class="remember-box checkbox">
					<label>
						<input v-model="payment_method" type="checkbox" checked="checked" value="mpesa" />Mpesa
					</label>
				</span>
			</div>
		</div>
		<div class="row">
			<div class="form-group">
				<div class="col-md-6">
					<label>Phone No</label>
					<input type="text" id="myPhoneNo" v-model="phone_no" class="form-control" />
				</div>
				<div class="col-md-6">
					<a href="#" @click.prevent="setFocus" class="pull-right">Change Phone Number</a>
				</div>
			</div>
		</div>
		<div class="actions-continue">
			<input
				type="button"
				@click="makeOrder"
				:value="btn"
				name="proceed"
				class="btn btn-lg btn-primary push-top"
			/>
		</div>
	</form>
</template>

<script>
	export default {
		props: ["user"],
		data() {
			return {
				location: null,
				pickup: null,
				loaded: false,
				phone_no: this.user.phone,
                payment_method: "mpesa",
                btn: "Place Order"
			};
		},
		methods: {
			makeOrder() {
                this.btn = "Placing order ..."
				// alert("Pending !!!");
				// this.$toast.error("An error occured, try again !");
				const body = {
					phone: this.phone_no,
					amount: this.pickup.delivery_fee + this.total,
					delivery_address: this.location.name + ", " + this.pickup.name,
					items: this.itemsInCart,
					payment_method: this.payment_method ?? 'mpesa',
					shipping_fee: this.pickup.delivery_fee,
					carts: this.cartItems,
					user_id: this.user.id
				};
				// console.log(body);
				axios
					.post("/order/make", body)
					.then(response => {
                        this.$toast.success("Success !");
                        console.log(response.data)
                        alert('Success')
                        this.btn = "Order Placed"
				    })
					.catch(error => {
						if (error.response.status === 403) {
                            this.$toast.error("An error occured, try again !");
                            alert(error.response.data.message)
						}
						if (error.response.status === 422) {
							console.log(error.response.data);
                        }
                        this.btn = "Place Order"
					});
			},
			quantity(id) {
				let record = this.cart.find(p => p.item.id === id);
				if (record) {
					return record.quantity;
				} else {
					return 0;
				}
			},
			setFocus() {
				document.getElementById("myPhoneNo").select();
				// document.getElementById("myPhoneNo").focus();
				return;
			}
		},
		mounted() {
			let data = this.$store.getters.shippingDetails;
			this.location = data[0].location;
			this.pickup = data[0].pickup;
		},
		computed: {
			cart() {
				return this.$store.getters.cart;
			},
			itemsInCart() {
				let cart = this.$store.getters.cart;
				return cart.reduce((accum, item) => accum + item.quantity, 0);
			},
			total() {
				let cart = this.$store.getters.cart;
				return cart.reduce((total, p) => {
					return total + p.item.selling_price * p.quantity;
				}, 0);
            },
            cartItems(){
                let cart = this.$store.getters.cart;
                let items = [];
                cart.forEach(p => {
                    items.push({product_id : p.item.id, items : p.quantity});
                })
                return items;
            },
		},
		filters: {
			currency(int) {
				return int.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
		}
	};
</script>