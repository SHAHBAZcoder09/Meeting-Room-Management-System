<script setup>
import { RouterView } from 'vue-router'
</script>

<template>
  <RouterView />
</template>

<style>
/* Global resets if needed, though main.css handles most */
html, body {
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;
}
#app {
  width: 100%;
  height: 100%;
  display: block; /* Override default grid/flex if any */
  max-width: none;
  padding: 0;
}
</style>
