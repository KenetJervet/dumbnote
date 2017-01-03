<template>
    <div class="main-view">
        <div class="tree-view">
            <folder-tree v-for="folder in rootFolders" :tree="folder"></folder-tree>
        </div>
        <div class="note-list">
        </div>
        <div class="note-view">
        </div>
  </div>
</template>

<script>
  import FolderTree from './FolderTree'

  export default {
    name: 'main-view',
    data () {
      return {
        rootFolders: []
      }
    },
    created () {
      this.http_get('folders').then(resp => {
        this.rootFolders = resp.data
      })
    },
    methods: {
    },
    components: {
      FolderTree
    }
  }
</script>

<style>
.main-view {
  background-color: rgba(240, 240, 240, 0.1);
  display: flex;
}

.main-page {
  background-color: #cccccc;
}

.tree-view {
}

.note-list {
}

.note-view {
}
</style>
