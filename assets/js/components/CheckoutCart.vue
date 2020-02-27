<template>
	<table cellspacing="0" class="shop_table cart">
		<thead>
			<tr>
				<th class="product-thumbnail">&nbsp;</th>
				<th class="product-name">Product</th>
				<th class="product-price">Price</th>
				<th class="product-quantity">Quantity</th>
				<th class="product-subtotal">Total</th>
			</tr>
		</thead>
		<tbody>
			<tr v-for="(item, $index) in cart" :key="$index" class="cart_table_item">
				<td class="product-thumbnail">
					<a :href="'/products/'+ item.item.slug">
						<img width="100" height="100" alt class="img-responsive" :src="item.item.images[0].name" />
					</a>
				</td>
				<td class="product-name">
					<a :href="'/products/'+ item.item.slug">{{item.item.name}}</a>
				</td>
				<td class="product-price">
					<span class="amount">Ksh. {{item.item.selling_price | currency}}</span>
				</td>
				<td class="product-quantity">{{quantity(item.item.id)}}</td>
				<td class="product-subtotal">
					<span class="amount">{{(item.item.selling_price * quantity(item.item.id)) | currency}}</span>
				</td>
			</tr>
		</tbody>
	</table>
</template>

<script>
	export default {
		methods: {
			quantity(id) {
				let record = this.cart.find(p => p.item.id === id);
				if (record) {
					return record.quantity;
				} else {
					return 0;
				}
			}
		},

		computed: {
			cart() {
				return this.$store.getters.cart;
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