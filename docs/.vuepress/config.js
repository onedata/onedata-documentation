const slugger = require('github-slugger').slug;
module.exports = {
  title: 'Onedata documentation',
  base: '/future-documentation/',
  markdown: {
    slugify: slugger,
    toc: {
      // changed because we want use remark-lint-no-undefined-references
      markerPattern: /^\[toc\]/im,
    },
  },
  themeConfig: {
    navbar: false,
    sidebar: [
      {
        title: 'Introduction',
        path: '/intro',
        collapsable: true
      },
      {
        title: 'User guide',
        path: '/user-guide/quickstart',
        collapsable: true,
        children: [
          '/user-guide/quickstart',
          '/user-guide/overview',
          '/user-guide/account-management',
          '/user-guide/groups',
          '/user-guide/spaces',
          '/user-guide/providers',
          '/user-guide/data',
          '/user-guide/data-distribution',
          '/user-guide/web-file-browser',
          '/user-guide/shares',
          '/user-guide/open-data',
          '/user-guide/tokens',
          '/user-guide/oneclient',
          '/user-guide/onedatafs',
          '/user-guide/rest-api',
          '/user-guide/qos',
          '/user-guide/data-transfer',
          '/user-guide/metadata',
          '/user-guide/data-discovery',
          '/user-guide/datasets',
          '/user-guide/archives',
//          '/user-guide/automation',
          '/user-guide/file-registration',
          '/user-guide/views',
          '/user-guide/cdmi'
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
            title: 'Onezone',
            collapsable: true,
            path: '/admin-guide/onezone/quickstart',
            children: [
              '/admin-guide/onezone/quickstart',
              '/admin-guide/onezone/overview',
              '/admin-guide/onezone/installation',
              '/admin-guide/onezone/maintenance',
              '/admin-guide/onezone/administration-panel',
              {
                title: 'Configuration',
                collapsable: false,
                path: '/admin-guide/onezone/configuration/oidc-saml',
                children: [
                  '/admin-guide/onezone/configuration/network-and-firewall',
                  '/admin-guide/onezone/configuration/cluster-nodes',
                  '/admin-guide/onezone/configuration/dns-config',
                  '/admin-guide/onezone/configuration/web-certificate',
                  '/admin-guide/onezone/configuration/user-management',
                  '/admin-guide/onezone/configuration/cluster-members',
                  '/admin-guide/onezone/configuration/gui-settings',
                  '/admin-guide/onezone/configuration/oidc-saml',
                  '/admin-guide/onezone/configuration/admin-privileges',
                  '/admin-guide/onezone/configuration/rest-api',
                  '/admin-guide/onezone/configuration/data-discovery',
                  '/admin-guide/onezone/configuration/handle-services',
                  '/admin-guide/onezone/configuration/advanced-config'
                ]
              }
            ]
          },
          {
            title: 'Oneprovider',
            collapsable: true,
            path: '/admin-guide/oneprovider/quickstart',
            children: [
              '/admin-guide/oneprovider/quickstart',
              '/admin-guide/oneprovider/overview',
              '/admin-guide/oneprovider/installation',
              '/admin-guide/oneprovider/maintenance',
              '/admin-guide/oneprovider/administration-panel',
              '/admin-guide/oneprovider/troubleshooting',
              {
                title: 'Configuration',
                collapsable: false,
                path: '/admin-guide/oneprovider/configuration/dns-config',
                children: [
                  '/admin-guide/oneprovider/configuration/network-and-firewall',
                  '/admin-guide/oneprovider/configuration/cluster-nodes',
                  '/admin-guide/oneprovider/configuration/dns-config',
                  '/admin-guide/oneprovider/configuration/web-certificate',
                  '/admin-guide/oneprovider/configuration/cluster-members',
                  '/admin-guide/oneprovider/configuration/storage-backends',
                  '/admin-guide/oneprovider/configuration/space-support',
                  '/admin-guide/oneprovider/configuration/storage-import',
                  '/admin-guide/oneprovider/configuration/luma',
                  '/admin-guide/oneprovider/configuration/file-popularity',
                  '/admin-guide/oneprovider/configuration/auto-cleaning',
                  '/admin-guide/oneprovider/configuration/qos',
                  '/admin-guide/oneprovider/configuration/rest-api',
                  '/admin-guide/oneprovider/configuration/advanced-config'
                ]
              }

            ]
          }
        ]
      },
      {
        title: 'Glossary',
        path: '/glossary',
        collapsable: true
      }
    ]
  }
};
