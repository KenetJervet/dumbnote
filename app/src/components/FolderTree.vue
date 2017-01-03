<template>
    <ul class="root">
        <li class="node">
            <span><button class="toggle-collapse-button" type="button" @click="toggleCollapse">{{ collapsed ? '+' : '-' }}</button> {{ tree.name }}</span>
            <folder-tree v-show="!collapsed" v-for="child in tree.children" :tree="child"></folder-tree>
        </li>
    </ul>
</template>

<script>
  // const {remote} = require('electron')
  // // import {remote} from 'electron'
  // const {Menu, MenuItem} = remote

  export default {
    name: 'folder-tree',
    props: {
      tree: Object
    },
    data () {
      return {
        collapsed: true
      }
    },
    methods: {
      toggleCollapse (evt) {
        evt.stopPropagation()
        this.collapsed = !this.collapsed
      },
      removeFolder () {
        alert(`${this.tree.name} has been deleted`)
      },
      contextMenu (evt) {
        // evt.preventDefault()
        // let menu = new Menu()
        // menu.append(new MenuItem({label: 'Remove', click () { this.removeFolder() }}))
        // // menu.append(new MenuItem({type: 'separator'}))
        // // menu.append(new MenuItem({label: 'MenuItem2', type: 'checkbox', checked: true}))
        // menu.popup(remote.getCurrentWindow())
      }
    }
  }
</script>

<style>
  .toggle-collapse-button {
    width: 30px;
  }
</style>
