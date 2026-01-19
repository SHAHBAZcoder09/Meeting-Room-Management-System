<script setup>
import { RouterView } from 'vue-router'
</script>

<template>
  <v-app>
    <RouterView />
  </v-app>
</template>

<style>
/* Global overrides handled by Vuetify theme */
html {
  overflow-y: auto !important;
}
</style>
