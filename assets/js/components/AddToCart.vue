<template>
	<span @click.prevent="addToCart">
		<i class="fa fa-shopping-cart"></i> Add to Cart
	</span>
</template>
<script>
	export default {
		props: ["item"],
		methods: {
			addToCart(item) {
				console.log(this.item);
				this.$store.dispatch("addToCart", this.item);
			}
		}
	};
</script>