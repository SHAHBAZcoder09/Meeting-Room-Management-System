<template>
  <v-menu>
    <template v-slot:activator="{ props }">
      <v-btn
        v-bind="props"
        variant="text"
        color="white"
        class="language-btn"
        size="small"
      >
        <v-icon start icon="mdi-translate" size="small"></v-icon>
        <span class="d-none d-sm-inline">{{ currentLanguageLabel }}</span>
        <v-icon end icon="mdi-chevron-down" size="small"></v-icon>
      </v-btn>
    </template>

    <v-list theme="dark" class="lang-menu" density="compact" bg-color="rgba(15, 23, 42, 0.95)">
      <v-list-item
        v-for="lang in languages"
        :key="lang.code"
        :active="locale === lang.code"
        @click="changeLanguage(lang.code)"
        class="lang-item"
      >
        <template v-slot:prepend>
          <span class="flag-emoji mr-2">{{ lang.flag }}</span>
        </template>
        <v-list-item-title>{{ lang.name }}</v-list-item-title>
      </v-list-item>
    </v-list>
  </v-menu>
</template>

<script setup>
import { computed } from 'vue';
import { useI18n } from 'vue-i18n';

const { locale, t } = useI18n();

const languages = [
  { code: 'en', name: 'English', flag: '🇺🇸' },
  { code: 'zh', name: '中文', flag: '🇨🇳' }
];

const currentLanguageLabel = computed(() => {
  const current = languages.find(l => l.code === locale.value);
  return current ? current.name : 'EN';
});

const changeLanguage = (code) => {
  locale.value = code;
  localStorage.setItem('locale', code);
};
</script>

<style scoped>
.language-btn {
  text-transform: none;
  font-weight: 500;
}

.lang-menu {
  border: 1px solid rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(20px);
}

.lang-item {
  min-height: 40px;
}

.flag-emoji {
  font-size: 1.2rem;
}
</style>
