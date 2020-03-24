<template>
	<span style="cursor: pointer;" @click.prevent="addToCart">
		<i class="fa fa-shopping-cart"></i> Add to Cart
	</span>
</template>
<script>
	export default {
		props: ["item"],
		methods: {
			addToCart() {
				this.$store.dispatch("addToCart", {item: this.item, count: 1});
			}
		}
	};
</script>