<template>
	<div>
		<div class="quantity">
			<input @click="removeCount" type="button" class="minus" value="-" />
			<input
				type="text"
				class="input-text qty text"
				title="Qty"
				:value="count"
				name="quantity"
				min="1"
				step="1"
			/>
			<input @click="addCount" type="button" class="plus" value="+" />
		</div>
		<button @click="addToCart" class="btn btn-primary btn-icon">Add to cart</button>
	</div>
</template>

<script>
	export default {
		data() {
			return {
				count: 1
			};
		},
		props: ["item"],
		methods: {
			addToCart() {
				this.$store.dispatch("addToCart", {item: this.item, count: this.count});
			},
			addCount() {
				return this.count++;
			},
			removeCount() {
				if (this.count > 1) {
					this.count--;
				}
				return;
			}
		}
	};
</script>