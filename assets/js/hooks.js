import moment from 'moment';

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
  TimeFormatter: {
    interval: null,
    mounted() {
      // console.log(moment(this.el.innerText).fromNow());
      this.formatTime();
      this.interval = setInterval(() => this.formatTime(), 60000);
    },
    destroyed() {
      clearInterval(this.interval);
    },
    formatTime() {
      const momentDateTime = moment(this.el.dataset.time);
      // console.log(momentDateTime.clone().startOf("day"))
      if (momentDateTime.clone().startOf('day').isSame(moment().startOf('day')))
        this.el.innerText = momentDateTime.fromNow();
      else
        this.el.innerText = momentDateTime.calendar({
          lastDay: '[Yesterday at] HH:mm',
          lastWeek: '[Last] dddd [at] HH:mm',
          sameElse: 'YYYY MMMM Do [at] HH:mm'
        });
    }
  }
};
