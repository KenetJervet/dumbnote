<template>
  <div>
      <router-link :to="`notes/${this.card.id}`"><h2>{{ this.card.title }}</h2>
      <p>{{ this.card.content }}</p>
  </div>
</template>

<script>
  export default {
    name: 'note-card',
    props: ['card']
  }
</script>
