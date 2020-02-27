<template>
	<table cellspacing="0" class="cart-totals">
		<tbody v-if="loaded">
			<tr class="cart-subtotal">
				<th>
					<strong>Cart Subtotal</strong>
				</th>
				<td>
					<strong>
						<span class="amount">Ksh. {{total | currency}}</span>
					</strong>
				</td>
			</tr>
			<tr class="shipping">
				<th>Shipping</th>
				<td>Ksh. {{pickup.delivery_fee | currency}}</td>
			</tr>
			<tr class="total">
				<th>
					<strong>Order Total</strong>
				</th>
				<td>
					<strong>
						<span class="amount">Ksh. {{(pickup.delivery_fee + total) | currency}}</span>
					</strong>
				</td>
			</tr>
		</tbody>
	</table>
</template>
<script>
	export default {
		data() {
			return {
				location: null,
				pickup: null,
				loaded: false
			};
		},
		mounted() {
			if (this.$store.getters.cart.length === 0) {
				this.$toast.error("No items in cart");
				return (window.location.href = "/");
			}
			let data = this.$store.getters.shippingDetails;
			// console.log(data);
			if (data.length === 0) {
				this.$toast.error("No items in cart");
				return (window.location.href = "/cart");
			}
			this.location = data[0].location;
			this.pickup = data[0].pickup;
			this.loaded = true;
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
			}
		},
		filters: {
			currency(int) {
				return int.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
		}
	};
</script>