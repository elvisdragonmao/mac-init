// ~/.finicky.js
// Finicky v4 config

const firefox = {
  name: "Firefox",
};

const chrome = {
  name: "Google Chrome",
};

const apps = {
  spotify: "Spotify",
  notion: "/Applications/Notion.app",
  zoom: "zoom.us",
  slack: "Slack",
  figma: "Figma",
};

// 只清掉常見追蹤參數，保留真正有用的 query，例如 meeting pwd、share token 等
const trackingParams = [
  "utm_source",
  "utm_medium",
  "utm_campaign",
  "utm_term",
  "utm_content",
  "utm_id",
  "fbclid",
  "gclid",
  "dclid",
  "gbraid",
  "wbraid",
  "msclkid",
  "ttclid",
  "twclid",
  "mc_cid",
  "mc_eid",
  "igshid",
  "ref_src",
];

export default {
  defaultBrowser: firefox,

  options: {
    checkForUpdates: true,
    logRequests: false,
    keepRunning: false,
    hideIcon: false,
  },

  rewrite: [

    {
      // 清掉 marketing / tracking 參數
      match: () => true,
      url: (url) => {
        for (const key of trackingParams) {
          url.searchParams.delete(key);
        }

        // 也處理 utm_* 這種 prefix
        for (const key of [...url.searchParams.keys()]) {
          if (
            key.startsWith("utm_") ||
            key.startsWith("vero_") ||
            key.startsWith("pk_")
          ) {
            url.searchParams.delete(key);
          }
        }

        return url;
      },
    },

    {
      // Notion web link → notion:// deep link
      // 這樣會更穩定地進 Notion app，而不是先進瀏覽器。
      match: (url) =>
        url.host === "notion.so" ||
        url.host === "www.notion.so" ||
        url.host.endsWith(".notion.site"),
      url: (url) => {
        url.protocol = "notion:";
        return url;
      },
    },
  ],

  handlers: [
    {
      // Google Meet 強制用 Chrome
      match: [
        "meet.google.com/*",
        "*.meet.google.com/*",
        "calendar.google.com/calendar/u/*/r/eventedit*",
      ],
      browser: chrome,
    },

    {
      // Spotify links → Spotify app
      // 常見分享連結例如 https://open.spotify.com/track/...
      match: [
        "open.spotify.com/*",
        "*.open.spotify.com/*",
        "spotify:*",
      ],
      browser: apps.spotify,
    },

    {
      // Notion links → Notion app
      match: [
        "notion:*",
        "notion.so/*",
        "www.notion.so/*",
        "*.notion.site/*",
      ],
      browser: apps.notion,
    },

    {
      // Zoom meeting links → Zoom app
      match: [
        "*.zoom.us/j/*",
        "*.zoom.us/wc/*",
        "*.zoom.us/my/*",
        "zoom.us/j/*",
        "zoommtg:*",
      ],
      browser: apps.zoom,
    },

    {
      // Slack links → Slack app
      match: [
        "*.slack.com/*",
        "slack:*",
      ],
      browser: apps.slack,
    },

    {
      // Figma / FigJam → Figma app
      match: [
        "figma.com/file/*",
        "figma.com/design/*",
        "figma.com/board/*",
        "figma.com/figjam/*",
        "*.figma.com/file/*",
        "*.figma.com/design/*",
        "*.figma.com/board/*",
        "*.figma.com/figjam/*",
      ],
      browser: apps.figma,
    },

    {
      // 本機開發
      match: [
        "localhost/*",
        "127.0.0.1/*",
        "*.local/*",
      ],
      browser: firefox,
    },

    {
      // catch-all：其他全部 Firefox
      match: () => true,
      browser: firefox,
    },
  ],
};