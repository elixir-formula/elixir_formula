module.exports = {
  theme: {
    fontFamily: {
      sans: [
        // "system-ui",
        "-apple-system",
        // "BlinkMacSystemFont",
        "Segoe UI",
        "Roboto",
        "Helvetica Neue",
        "Arial",
        "Noto Sans",
        "sans-serif",
        "Apple Color Emoji",
        "Segoe UI Emoji",
        "Segoe UI Symbol",
        "Noto Color Emoji",
      ],
    },
  },
  variants: {
    textColor: ['hover'],
    display: ["responsive", "focus", "dropdown"]
  },
  plugins: [require('tailwindcss-dropdown')],
  future: {
    removeDeprecatedGapUtilities: true,
  },
};
