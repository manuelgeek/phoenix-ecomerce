import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)
const CART_NAME = "ph-cart"

export default new Vuex.Store({
    state: {
        added: JSON.parse(localStorage.getItem(CART_NAME)) || [],
    },
    getters: {
        cart: state => state.added,
    },
    mutations: {
        removeCart(state) {
            localStorage.removeItem(CART_NAME);
            state.added = [];
        },
        ADD_TO_CART(state, payload) {
            const record = state.added.find(p => p.item.id === payload.item.id)
            if (!record) {
                state.added.push({
                    item: payload.item,
                    quantity: payload.count,
                })
            } else {
                record.quantity = record.quantity + payload.count
            }

            localStorage.setItem(CART_NAME, JSON.stringify(state.added));
        },
        REMOVE_FROM_CART(state, payload) {
            const record = state.added.find(p => p.item.id === payload.id)
            if (!record) {
                return;
            } else {
                if (record.quantity > 1) {
                    record.quantity--;
                } else if (record.quantity == 1) {
                    var index = state.added.findIndex(function (p) {
                        return (p.item.id === payload.id);
                    });
                    state.added.splice(index, 1);
                }
            }

            localStorage.setItem(CART_NAME, JSON.stringify(state.added));
        },
        REMOVE_WHOLE_FROM_CART(state, payload) {
            const record = state.added.find(p => p.item.id === payload.id)
            if (!record) {
                return;
            } else {
                var index = state.added.findIndex(function (p) {
                    return (p.item.id === payload.id);
                });
                state.added.splice(index, 1);
            }

            localStorage.setItem(CART_NAME, JSON.stringify(state.added));
        },
    },
    actions: {
        addToCart({ commit }, payload) {
            commit('ADD_TO_CART', { item: payload.item, count: payload.count })
        },
        removeFromCart({ commit }, payload) {
            commit('REMOVE_FROM_CART', payload);
        },
        removeWholeFromCart({ commit }, payload) {
            commit('REMOVE_WHOLE_FROM_CART', payload);
        },
        removeCart(context) {
            context.commit('removeCart');
        }
    }
})