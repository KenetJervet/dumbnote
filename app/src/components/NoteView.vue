<template>
  <div>
    <h2>{{ this.card.title }}</h2>
    <hr>
    <p>{{ this.card.content }}</p>
    <!-- TODO: Help me with HTML tags -->
    <footer>
        <p>{{ this.card.creationTime }}</p>
        <p><router-link to="/notes">Back</router-link></p>
    </footer>
  </div>
</template>

<script>
  export default {
    name: 'note-view',
    data () {
      return {
        card: {}
      }
    },
    created () {
      let uuid = this.$route.params.id
      this.http_get(`/notes/${uuid}`).then(resp => {
        this.card = resp.data
      })
    }
  }
</script>
