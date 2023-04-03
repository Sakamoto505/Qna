import consumer from "./consumer"

consumer.subscriptions.create({channel: "QuestionsChannel"}, {
  connected() {
    console.log('Questions channel connected.');
    this.perform('follow');
  },

  received(data) {
    console.log('123123');

    $('.questions').append(data);
  }
});