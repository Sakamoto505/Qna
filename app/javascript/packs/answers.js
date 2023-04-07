
    $(document).on('turbolinks:load', function() {
        // Обработчик успешной отправки формы с новым ответом
        $('form.new-answer').on('ajax:success', function(e) {
            let answer = e.detail[0];

        // Добавление нового ответа на страницу
        $('.answers').append(`
      <div class="answer" id="${answer.id}">
        <p>${answer.body}</p>
      </div>
    `);
    })
        // Обработчик ошибки отправки формы с новым ответом
        .on('ajax:error', function(e) {
            $('.answer-errors').empty();
            let errors = e.detail[0];

            $.each(errors, function(index, value) {
                $('.answer-errors').append('<p>' + value + '</p>');
            })
        })
});

