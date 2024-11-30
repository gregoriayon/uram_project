const initialValues = [];

$(document).ready(function () {
    setUpdateUserData();

    $('#up_role_name').select2({
        placeholder: 'Select Roles',
        allowClear: true,
        ajax: {
            url: '/api/userRoles',
            type: 'GET',
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    query: params.term || '',
                    limit: 10
                };
            },
            processResults: function (data) {
                return {
                    results: data.map(function (item) {
                        return { id: item, text: item };
                    })
                };
            },
            cache: true
        },
        minimumInputLength: 0,
        dropdownCssClass: "select2-dropdown",
    });

    // Add roles once `setUpdateUserData` is complete
    $('#up_role_name').on('select2:open', function () {
        const $select = $(this);
        if (!$select.data('loaded')) {
            $.ajax({
                url: '/api/userRoles',
                type: 'GET',
                dataType: 'json',
                data: { limit: 10 },
                success: function (data) {
                    data.forEach(function (item) {
                        if (!initialValues.includes(item)) { // Avoid duplicate options
                            const option = new Option(item, item, false, false);
                            $select.append(option);
                        }
                    });
                    $select.trigger('change');
                    $select.data('loaded', true);
                }
            });
        }
    });
});

function setUpdateUserData() {
    var urlParams = new URLSearchParams(window.location.search);
    var userId = urlParams.get('user_id');

    $.get(`api/update_api_user?user_id=${userId}`)
        .done(function (res) {
            $('#up_user_username').val(res.user.username);
            $('#up_userType').val(res.user.type);
            $('#up_user_email').val(res.user.email);
            $('#up_user_phone').val(res.user.phone);
            $('#up_user_details').val(res.user.details);

            // Populate `initialValues` and append to Select2
            if (res.roles && res.roles.length > 0) {
                res.roles.forEach(role => {
                    initialValues.push(role.role_name);

                    // Add roles to the Select2 element
                    const option = new Option(role.role_name, role.role_name, true, true);
                    $('#up_role_name').append(option);
                });

                // Trigger change to notify Select2 about the new values
                $('#up_role_name').val(initialValues).trigger('change');
            }
        })
        .fail(function (error) {
            show_error_message(error.responseJSON.error);
        });
}

function updateAPIUser(){
    var urlParams = new URLSearchParams(window.location.search);
    var userId = urlParams.get('user_id');

    $.ajax({
        url: `api/update_api_user?user_id=${userId}`,
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            username: $('#up_user_username').val(),
            user_type: $('#up_userType').val(),
            email: $('#up_user_email').val(),
            phone: $('#up_user_phone').val(),
            details: $('#up_user_details').val(),
            roles: $('#up_role_name').val() || []
        }),
        success: function (response) {
            show_success_message(response.success);
        },
        error: function (error) {
            show_error_message(error.responseJSON.error);
        }
    });
}