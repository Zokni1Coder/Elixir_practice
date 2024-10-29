/**
 * @type {Object.<string, import("phoenix_live_view").ViewHook>}
 */
export default {
  NewMessage: {
    mounted() {
      this.handleEvent('new_message', (_payload) => {
        if (
          this.el.scrollHeight - (this.el.scrollTop + this.el.clientHeight) <
          100
        )
          this.el.scrollTo({ top: this.el.scrollHeight, behavior: 'smooth' });
      });
      // console.log('asasdasdasd')
    }
  },
  TimeFormatter: {}
};
