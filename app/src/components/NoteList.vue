<template>
  <div>
    <note-card v-for="card in cards" :card="card"></note-card>
  </div>
</template>

<script>
  import NoteCard from './NoteCard'
  export default {
    name: 'note-list',
    created () {
      this.http_get('notes').then(resp => {
        this.cards = resp.data
      })
    },
    data () {
      return {
        cards: []
      }
    },
    components: {
      NoteCard
    }
  }
</script>
