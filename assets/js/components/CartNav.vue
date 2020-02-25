<template>
	<li class="dropdown mega-menu-item mega-menu-shop">
		<a class="dropdown-toggle mobile-redirect" href="#">
			<i class="fa fa-shopping-cart"></i>
			({{itemsInCart}}) - Ksh. {{total | currency}}
			<i class="fa fa-angle-down"></i>
		</a>
		<ul class="dropdown-menu">
			<li v-if="itemsInCart > 0">
				<div class="mega-menu-content">
					<div class="row">
						<div class="col-md-12">
							<table cellspacing="0" class="cart">
								<tbody>
									<tr v-if="itemsInCart > 0">
										<td class="product-thumbnail">
											<a :href="'/products/' + cart[0].item.slug">
												<img
													width="100"
													height="100"
													alt
													class="img-responsive"
													:src="cart[0].item.images[0].name"
												/>
											</a>
										</td>
										<td class="product-name">
											<a :href="'/products/' + cart[0].item.slug">
												{{cart[0].item.name}}
												<br />
												<span class="amount">
													<strong>Ksh. {{cart[0].item.selling_price}}</strong>
												</span>
											</a>
										</td>
                                        <td>
                                            <div class="amount">
                                                <b>{{quantity(cart[0].item.id)}}</b>
                                            </div>
                                        </td>
										<td class="product-actions">
											<a @click.prevent="removeFromCart(cart[0].item)" title="Remove this item" class="remove" href="#">
												<i class="fa fa-times"></i>
											</a>
										</td>
									</tr>
									<tr>
										<td class="actions" colspan="6">
											<div class="actions-continue">
												<!-- <input @click="cartRedirect" type="submit" value="View All" class="btn btn-default" /> -->
												<input @click="cartRedirect"
													type="submit"
													value="Proceed to Cart →"
													name="proceed"
													class="btn pull-right btn-primary"
												/>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</li>
		</ul>
	</li>
</template>

<script>
	export default {
		methods: {
			removeFromCart(item) {
				this.$store.dispatch("removeFromCart", item);
            },
            quantity(id){
                let record = this.cart.find(p => p.item.id === id)
                if(record){
                    return record.quantity ;
                }else{
                    return 0 ;
                }
            },
            cartRedirect(){
                return window.location.href = '/cart'
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
			}
		},
		filters: {
			currency(int) {
				return int.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
		}
	};
</script>