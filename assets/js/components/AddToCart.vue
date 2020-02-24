<template>
	<span @click.prevent="addToCart">
		<i class="fa fa-shopping-cart"></i> Add to Cart
	</span>
</template>
<script>
	export default {
		props: ["item"],
		methods: {
			addToCart() {
				let item = JSON.parse(this.item);
				this.$store.dispatch("addToCart", item);
			}
		}
	};
</script>