<template>
    <div @click="selectNote">
        <h4>{{ this.note.title }}</h4>
        <p>{{ this.note.content }}</p>
    </div>
</template>

<script>
  export default {
    name: 'note-card',
    props: ['note']
  }
</script>
