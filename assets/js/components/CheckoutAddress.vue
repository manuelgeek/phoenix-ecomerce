<template>
	<form action id method="post">
		<div v-if="loaded" class="row">
			<div class="form-group">
				<div class="col-md-6">
					<label>City</label>
					<input type="text" v-model="location.name" readonly class="form-control" />
				</div>
				<div class="col-md-6">
					<label>Pick Up</label>
					<input type="text" v-model="pickup.name" class="form-control" readonly />
				</div>
			</div>

			<div class="form-group">
				<div class="col-md-6">
					<label>Delivery Cost</label>
					<input type="text" :value="'Ksh. ' + pickup.delivery_fee" class="form-control" readonly />
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<input
					@click="redirectToCart"
					type="button"
					value="Change Delivery Address"
					class="btn btn-primary pull-right push-bottom"
					data-loading-text="Loading..."
				/>
			</div>
		</div>
	</form>
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
		methods: {
			redirectToCart() {
				return (window.location.href = "/cart");
			}
		},
		mounted() {
			let data = this.$store.getters.shippingDetails;
			if (data.length === 0) {
				this.$toast.error("No items in cart");
				return (window.location.href = "/cart");
			}
			this.location = data[0].location;
            this.pickup = data[0].pickup;
            this.loaded = true
		}
	};
</script>