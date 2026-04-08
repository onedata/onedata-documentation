const slugger = require('github-slugger').slug;
const { getMajorRelease } = require('./utils.js');
const majorRelease = getMajorRelease();
module.exports = {
  title: 'Onedata documentation',
  base: `/documentation/${majorRelease}/`,
  head: [
    ['script', { src: 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js' }]
  ],
  markdown: {
    slugify: slugger,
    toc: {
      // changed because we want use remark-lint-no-undefined-references
      markerPattern: /^\[toc\]/im,
    },
  },
  plugins: [
    require('./plugin-style-generator.js'),
    require('./plugin-template-renderer.js'),
    require('./vuepress-plugin-mermaidjs-cdn/index.js')
  ],
  temp: '/tmp/.vuepress-temp',
  themeConfig: {
    navbar: false,
    sidebar: [
      {
        title: 'Introduction',
        path: '/intro',
        collapsable: false
      },
      {
        title: 'User guide',
        path: '/user-guide/quickstart',
        collapsable: true,
        children: [
          '/user-guide/quickstart',
          // '/user-guide/overview',
          '/user-guide/account-management',
          '/user-guide/groups',
          '/user-guide/spaces',
          '/user-guide/providers',
          '/user-guide/data',
          {
            title: 'Data access interfaces',
            collapsable: false,
            path: '/user-guide/interfaces/overview',
            children: [
              '/user-guide/interfaces/overview',
              '/user-guide/interfaces/web-file-browser',
              '/user-guide/interfaces/oneclient',
              '/user-guide/interfaces/onedata-fs',
              '/user-guide/interfaces/onedata-rest-fs',
              '/user-guide/interfaces/onedata-file-rest-client',
              // '/user-guide/interfaces/s3',
              '/user-guide/interfaces/data-access-rest-api',
              '/user-guide/interfaces/cdmi'
            ]
          },
          '/user-guide/data-distribution-and-metrics',
          '/user-guide/dir-stats',
          '/user-guide/data-transfers',
          '/user-guide/rule-based-replication-qos',
          '/user-guide/shares',
          '/user-guide/public-data',
          '/user-guide/tokens',
          '/user-guide/metadata',
          '/user-guide/data-discovery',
          '/user-guide/datasets',
          '/user-guide/archives',
//          '/user-guide/automation',
          '/user-guide/file-registration',
          '/user-guide/views',
          '/user-guide/rest-api'
        ]
      },
      {
        title: 'Admin guide',
        path: '/admin-guide/overview',
        collapsable: true,
        children: [
          '/admin-guide/overview',
          '/admin-guide/architecture',
          '/admin-guide/demo-mode',
          {
            title: 'Oneprovider',
            collapsable: true,
            path: '/admin-guide/oneprovider/installation',
            children: [
              // TODO VFS-11766 we need a landing page for oz and op (like overview)
              // TODO VFS-11766 when it's there, adjust docs-topic-aliases.js (homepage)
              '/admin-guide/oneprovider/installation',
              '/admin-guide/oneprovider/maintenance',
              '/admin-guide/oneprovider/administration-panel',
              '/admin-guide/oneprovider/troubleshooting',
              {
                title: 'Configuration',
                collapsable: false,
                path: '/admin-guide/oneprovider/configuration/cluster-members',
                children: [
                  // TODO VFS-11766 move this section further down when there's content in others
                  '/admin-guide/oneprovider/configuration/cluster-members',
                  '/admin-guide/oneprovider/configuration/network-and-firewall',
                  '/admin-guide/oneprovider/configuration/cluster-nodes',
                  '/admin-guide/oneprovider/configuration/dns-config',
                  '/admin-guide/oneprovider/configuration/web-certificate',
                  '/admin-guide/oneprovider/configuration/storage-backends',
                  '/admin-guide/oneprovider/configuration/space-support',
                  '/admin-guide/oneprovider/configuration/storage-import',
                  '/admin-guide/oneprovider/configuration/luma',
                  '/admin-guide/oneprovider/configuration/file-popularity',
                  '/admin-guide/oneprovider/configuration/auto-cleaning',
                  '/admin-guide/oneprovider/configuration/rule-based-replication-qos',
                  '/admin-guide/oneprovider/configuration/rest-api',
                  '/admin-guide/oneprovider/configuration/advanced-config',
                  '/admin-guide/oneprovider/configuration/accounting-and-dir-stats'
                ]
              }

            ]
          },
          {
            title: 'Onezone',
            collapsable: true,
            path: '/admin-guide/onezone/installation',
            children: [
              // TODO VFS-11766 we need a landing page for oz and op (like overview)
              // TODO VFS-11766 when it's there, adjust docs-topic-aliases.js (homepage)
              '/admin-guide/onezone/installation',
              '/admin-guide/onezone/maintenance',
              '/admin-guide/onezone/administration-panel',
              '/admin-guide/onezone/troubleshooting',
              {
                title: 'Configuration',
                collapsable: false,
                path: '/admin-guide/onezone/configuration/oidc-saml',
                children: [
                  // TODO VFS-11766 move those sections further down when there's content in others
                  '/admin-guide/onezone/configuration/oidc-saml',
                  '/admin-guide/onezone/configuration/oidc-google-idp',
                  '/admin-guide/onezone/configuration/network-and-firewall',
                  '/admin-guide/onezone/configuration/cluster-nodes',
                  '/admin-guide/onezone/configuration/dns-config',
                  '/admin-guide/onezone/configuration/web-certificate',
                  '/admin-guide/onezone/configuration/user-management',
                  '/admin-guide/onezone/configuration/cluster-members',
                  '/admin-guide/onezone/configuration/gui-settings',
                  '/admin-guide/onezone/configuration/admin-privileges',
                  '/admin-guide/onezone/configuration/rest-api',
                  '/admin-guide/onezone/configuration/data-discovery',
                  '/admin-guide/onezone/configuration/handle-services',
                  '/admin-guide/onezone/configuration/advanced-config'
                ]
              }
            ]
          }
        ]
      },
      {
        title: 'Glossary',
        path: '/glossary',
        collapsable: false
      }
    ]
  }
};
