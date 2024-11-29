$(document).ready(function() {
    applySelect2Theme();
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', applySelect2Theme);

    // side-bar dropdown show, hide
    var currentPath = window.location.pathname;
    if (currentPath !== '/create_account' && currentPath !== '/user_list') {
        $('#userMenu').removeClass('show');
    }
});


function show_error_message(msg){
    $('#toast_msg').text(msg);
    tata.error('', $('#toast_msg').text(), {
        position: 'tr',
        duration: 5000
    })
}

function show_success_message(msg){
    $('#toast_msg').text(msg);
    tata.success('', $('#toast_msg').text(), {
        position: 'tr',
        duration: 5000,
    })
}


function commonAutocomplete(element_id){
    element_id.select2({
        placeholder: 'Select Role',
        allowClear: true,
        ajax: {
            url: '/api/userRoles', // API endpoint
            type: 'GET',
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    query: params.term || '', // Search term
                    limit: 10                 // Limit results
                };
            },
            processResults: function (data) {
                return {
                    results: data.map(function (item) {
                        return { id: item, text: item }; // Transform data
                    })
                };
            },
            cache: true
        },
        minimumInputLength: 0, // Minimum characters to start search
        dropdownCssClass: "select2-dropdown"
    });
    
    // Preload options when the dropdown opens for the first time
    element_id.on('select2:open', function () {
        const $select = $(this);
        if (!$select.data('loaded')) {
            $.ajax({
                url: '/api/userRoles', // API endpoint
                type: 'GET',
                dataType: 'json',
                data: { limit: 10 },
                success: function (data) {
                    data.forEach(function (item) {
                        const option = new Option(item, item, false, false);
                        $select.append(option);
                    });
                    $select.trigger('change');
                    $select.data('loaded', true); // Mark as loaded
                }
            });
        }
    });
}


function commonModalAutocomplete(element_id, li_element, li_id_name){
    element_id.on('input', function() {
        var query = $(this).val();
        if (query.length > 0) {
            $.get('api/autocompleteRoles', { query: query }, function(data) {
                var suggestions = li_element;
                suggestions.empty(); // Clear any previous suggestions
                if (data.length > 0) {
                    data.forEach(function(item) {
                        suggestions.append('<li class="list-group-item">' + item + '</li>');
                    });
                    suggestions.show();
                } else {
                    suggestions.hide();
                }
            });
        } else {
            $li_element.hide();
        }
    });
    

    $(document).on('click', `#${li_id_name} li`, function() {
        var selectedValue = $(this).text();
        element_id.val(selectedValue);
        li_element.hide();
    });
}


function applySelect2Theme() {
    const darkMode = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
    if (darkMode) {
        $('.js-example-basic-multiple').select2({
            theme: 'dark',
        });
    } else {
        $('.js-example-basic-multiple').select2({
            theme: 'default',
        });
    }
}