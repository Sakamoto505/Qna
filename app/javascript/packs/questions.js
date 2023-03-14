$(document).on('turbolinks:load', function(){
    $('.question').on('click', '.edit-question-link', function(e) {
        e.preventDefault();
        $(this).hide();
        let questionId = $(this).data('questionId');
        $('form#edit-question-' + questionId).removeClass('hidden');
    });

    return loadGists();
});

window.loadGists = function () {
    $('.gist').each(function () {
        loadGist($(this));
    });
};

window.loadGist = function ($gist) {
    let callbackName, script, html;
    callbackName = 'c' + Math.random().toString(36).substring(7);

    window[callbackName] = function (gistData) {
        delete window[callbackName];
        html = '<link rel="stylesheet" href="' + encodeURI(gistData.stylesheet) + '"></link>';
        html += gistData.div;
        $gist.html(html);
        return script.parentNode.removeChild(script);
    };

    script = document.createElement('script');
    script.setAttribute('src', [
        $gist.data('src'), $.param({
            callback: callbackName,
            file: $gist.data('file') || ''
        })
    ].join('?'));

    document.body.appendChild(script);

    $(document).on('ajax:success', 'form', function(event) {
        let data = event.detail[0];

        // Обновляем форму редактирования
        $('.edit-question-form').html(data.form);

        // Обновляем список ссылок
        $('#question-links').html(data.links);

        // Очищаем форму редактирования
        $(this).find('input[type=text], textarea').val('');

        // Обновляем заголовок и текст вопроса
        $('#question-title').text(data.question.title);
        $('#question-body').text(data.question.body);

        // Обновляем ссылки на файлы
        let filesHtml = '';
        data.question.files.forEach(function(file) {
            filesHtml += '<p><a href="' + file.url + '">' + file.filename + '</a></p>';
        });
        $('#question-files').html(filesHtml);

        // Показываем кнопку редактирования
        $('.edit-question-link').show();
        // Скрываем форму редактирования
        $('.edit-question-form').addClass('hidden');
    });
};
