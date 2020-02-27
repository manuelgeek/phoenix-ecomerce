<template>
	<div>
		<div v-if="itemsInCart > 0" class="row featured-boxes cart">
			<div class="col-md-6">
				<div class="featured-box featured-box-secundary default">
					<div class="box-content">
						<h4>Calculate Shipping</h4>
						<form action id method="post">
							<div class="row">
								<div class="form-group">
									<div class="col-md-12">
										<label>
											City
											<sup class="text-danger">*</sup>
										</label>
										<select v-model="location" class="form-control">
											<option selected value>Select City</option>
											<option
												v-for="(address, $index) in addresses"
												:key="$index"
												:value="address"
											>{{address.name}}</option>
										</select>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="form-group">
									<div class="col-md-12">
										<label>
											Pickup Location
											<sup class="text-danger">*</sup>
										</label>
										<select v-model="pickup" class="form-control">
											<option selected value>Select Pick Up</option>
											<option v-for="(pickup, $index) in pickups" :key="$index" :value="pickup">{{pickup.name}}</option>
										</select>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="featured-box featured-box-secundary default">
					<div class="box-content">
						<h4>Cart Totals</h4>
						<table cellspacing="0" class="cart-totals">
							<tbody>
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
									<td>Ksh. {{shipping_fee | currency}}</td>
								</tr>
								<tr class="total">
									<th>
										<strong>Order Total</strong>
									</th>
									<td>
										<strong>
											<span class="amount">Ksh. {{(shipping_fee + total) | currency}}</span>
										</strong>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col-md-12">
				<div class="actions-continue">
					<input
						@click="checkOut"
						type="button"
						:disabled="shipping_fee === 0"
						value="Proceed to Checkout →"
						name="proceed"
						class="btn btn-lg btn-primary"
					/>
				</div>
			</div>
		</div>
	</div>
</template>
<script>
	export default {
		data() {
			return {
				addresses: [],
				location: null,
				pickups: [],
				pickup: null
			};
		},
		mounted() {
			this.getAddresses();
		},
		methods: {
			getAddresses() {
				axios.get("/addresses").then(response => {
					this.addresses = response.data.data;
				});
			},
			checkOut() {
				this.$store
					.dispatch("shippingDetails", {
						location: this.location,
						pickup: this.pickup
					})
					.then(e => (window.location.href = "/checkout"));
			}
		},
		computed: {
			baseUrl() {
				return process.env.VUE_APP_URL;
			},
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
			shipping_fee() {
				return this.pickup === null ? 0 : this.pickup.delivery_fee;
			}
		},
		watch: {
			location: function(value) {
				this.pickups = value.pickups;
			}
		},
		filters: {
			currency(int) {
				return int.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
		}
	};
</script>