// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"


import "phoenix_html"

import axios from 'axios'
window.axios = axios;
axios.defaults.headers.common['Accept'] = 'application/json'
let token = document.head.querySelector('meta[name="csrf_token"]');
if (token) {
    axios.defaults.headers.common['X-CSRF-TOKEN'] = token.content;
} else {
    console.log('CSRF not found')
}


import Vue from "vue";
import App from "./App";
import Message from './components/Message'
import AddToCart from './components/AddToCart'
import CartNav from './components/CartNav'
import AddToCartMultiple from './components/AddToCartMultiple'
import Cart from './components/Cart'
import CartTotals from './components/CartTotals'
import CheckoutTotal from './components/CheckoutTotal'
import CheckoutAddress from './components/CheckoutAddress'
import CheckoutCart from './components/CheckoutCart'
import Checkout from './components/Checkout'
import store from './store'
import { initialize } from "./helpers/initialization"

initialize(store)

import VueIziToast from 'vue-izitoast';
Vue.use(VueIziToast, { position: 'topRight' });

Vue.component('message', Message);
Vue.component('addToCart', AddToCart);
Vue.component('cartNav', CartNav);
Vue.component('addToCartMultiple', AddToCartMultiple);
Vue.component('cart', Cart);
Vue.component('cartTotals', CartTotals);
Vue.component('checkoutTotal', CheckoutTotal);
Vue.component('checkoutAddress', CheckoutAddress);
Vue.component('CheckoutCart', CheckoutCart);
Vue.component('checkout', Checkout);

new Vue({
    store,
    el: "#app"
});
// new Vue({
//     render: h => h(App)
// }).$mount("#app")
