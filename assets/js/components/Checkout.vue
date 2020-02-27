<template>
	<form action id method="post">
		<div class="row">
			<div class="col-md-12">
				<span class="remember-box checkbox">
					<label>
						<input type="checkbox" checked="checked" />Mpesa
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
			<input type="submit" value="Place Order" name="proceed" class="btn btn-lg btn-primary push-top" />
		</div>
	</form>
</template>

<script>
	export default {
		props: ["phone"],
		data() {
			return {
				location: null,
				pickup: null,
				loaded: false,
				phone_no: this.phone
			};
		},
		methods: {
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
			}
		},
		filters: {
			currency(int) {
				return int.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
		}
	};
</script>