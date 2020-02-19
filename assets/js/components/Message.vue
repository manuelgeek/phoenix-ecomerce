<template>
  <div class="vue-message">
    <button @click="sayHello()">Click me</button>
    <div v-if="showMessage">{{ message }}</div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      message: "Hello from Vue!",
      showMessage: false
    }
  },
  methods: {
    sayHello() {
      this.showMessage = true
    }
  },
  created() {
    console.log("Vue component created")
  }
}
</script>

 
<style>
.vue-message {
  text-align: center;
  font-size: 2em;
}
</style>