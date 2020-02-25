<template>
	<table cellspacing="0" class="shop_table cart">
		<thead v-if="itemsInCart > 0">
			<tr>
				<th class="product-remove">&nbsp;</th>
				<th class="product-thumbnail">&nbsp;</th>
				<th class="product-name">Product</th>
				<th class="product-price">Price</th>
				<th class="product-quantity">Quantity</th>
				<th class="product-subtotal">Total</th>
			</tr>
		</thead>
		<tbody v-if="itemsInCart > 0">
			<tr v-for="(item, $index) in cart" :key="$index" class="cart_table_item">
				<td class="product-remove">
					<a title="Remove this item" @click.prevent="removeWholeFromCart(item.item)" class="remove" href="#">
						<i class="fa fa-times"></i>
					</a>
				</td>
				<td class="product-thumbnail">
					<a :href="'/products/' + item.item.slug">
						<img
							width="100"
							height="100"
							alt
							class="img-responsive"
							:src="item.item.images[0].name"
						/>
					</a>
				</td>
				<td class="product-name">
					<a :href="'/products/' + item.item.slug">{{item.item.name}}</a>
				</td>
				<td class="product-price">
					<span class="amount">Ksh. {{item.item.selling_price | currency}} </span>
				</td>
				<td class="product-quantity">
					<form enctype="multipart/form-data" method="post" class="cart">
						<div class="quantity">
							<input @click="removeFromCart(item.item)" type="button" class="minus" value="-" />
							<input
								type="text"
								class="input-text qty text"
								title="Qty"
								:value="quantity(item.item.id)"
								name="quantity"
								min="1"
								step="1"
							/>
							<input @click="addToCart(item.item)" type="button" class="plus" value="+" />
						</div>
					</form>
				</td>
				<td class="product-subtotal">
					<span class="amount">Ksh {{(quantity(item.item.id) * item.item.selling_price) | currency}} </span>
				</td>
			</tr>
		</tbody>
        <tbody v-else>
                <tr>
                    <td colspan="5" class="text-center">
                        <br>
                        <h4>No Items in Cart yet</h4>
                        <br><br>
                    <a class="btn btn-primary" href="/products">Continue Shopping</a>
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
			},
			addToCart(item) {
				this.$store.dispatch("addToCart", {item: item, count: 1});
			},
			removeFromCart(item) {
				this.$store.dispatch("removeFromCart", item);
            },
            removeWholeFromCart(item){
                this.$store.dispatch('removeWholeFromCart', item);
            },
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
			}
		},
		filters: {
			currency(int) {
				return int.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
		}
	};
</script>