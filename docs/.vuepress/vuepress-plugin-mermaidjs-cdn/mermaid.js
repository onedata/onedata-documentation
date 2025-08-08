/**
 * Part of original vuepress-plugin-mermaidjs customized to work with Mermaid.js from CDN.
 * 
 * See: https://github.com/eFrane/vuepress-plugin-mermaidjs
 * 
 * @author Stefan "eFrane" Graupner, Jakub Liput
 * @copyright (C) 2019-present Stefan "eFrane" Graupner, (C) 2025 ACK CYFRONET AGH
 * @license This software is released under the MIT license cited in 'LICENSE.txt'.
 */

const Mermaid = {
  name: 'Mermaid',
  props: {
    id: {
      type: String,
      required: false,
      default () {
        return 'diagram_' + Date.now();
      }
    },
    graph: {
      type: String,
      required: false
    }
  },
  data() {
    return {
      svg: undefined,
      error: undefined
    }
  },
  computed: {
    graphData() {
      if (this.graph) {
        return this.graph;
      }

      console.warn('Using vuepress-plugin-mermaidjs via the default slot is deprecated and will be removed in v2.0.');

      return this.$slots.default[0].text;
    }
  },
  render(h) {
    if (this.svg === undefined) {
      if (this.error) {
        return h('div', {
          class: ['mermaid-error'],
          domProps: {
            innerHTML: `<p title="${escapeHtml(String(this.error))}">Diagram could not be displayed.</p><p>Please try refreshing the page. If the problem persists, <a href="https://onedata.org/#/home/contact" target="_blank">contact the site administrator</a>.</p>`
          }
        })
      } else {
        return h('div', {
          class: ['spinner']
        });
      }
    }

    return h('div', {
      class: ['mermaid-diagram'],
      domProps: {
        innerHTML: this.svg,
        style: 'width: 100%'
      }
    })
  },
  async mounted() {
    window.mermaid.initialize({
      // put Mermaid options below: https://mermaid.js.org/config/setup/mermaid/interfaces/MermaidConfig.html
      startOnLoad: true,
      theme: 'base',
      themeVariables: {
        primaryColor: '#fff',
        background: '#efefef',
        primaryTextColor: '#363636',
        primaryBorderColor: '#EE3F3F',
        lineColor: '#363636',
        secondaryColor: '#efefef',
        secondaryBorderColor: '#555555',
        tertiaryColor: '#fafafa',
        tertiaryBorderColor: '#909090',
      },
    })
    try {
      const { svg } = await window.mermaid.render(this.id, this.graphData);
      this.svg = svg;
    } catch (error) {
      this.error = error;
      throw error;
    }
  }
}

function escapeHtml(text) {
  return text.replace(/[&<>"']/g, match => ({
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#039;',
  }[match]));
}

export default ({ Vue }) => {
  Vue.component(Mermaid.name, Mermaid);
}