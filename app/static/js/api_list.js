$(document).ready(function (){
    commonAutocomplete($('#filter_api_role'));
    const setRoleName = $('#APIRoleName').text();
    if (setRoleName) {
        const option = new Option(setRoleName, setRoleName, true, true);
        $('#filter_api_role').append(option).trigger('change');
    }

    get_all_api_list();
})


function create_api(){
    const urlParams = new URLSearchParams(window.location.search);
    const roleName = urlParams.get('role_name');
    const params = {
        api_role: $('#api_role_name').val(),
        api_type: $('#api_type').val(),
        api_link: $('#api_link_text').val(),
        api_details: $('#api_details').val()
    }
    $.get('api/create_api', params)
        .done(function (response) {
            if (!roleName) {
                $('#api_role_name').val('');
            }
            $('#api_type').val('')
            $('#api_link_text').val('')
            $('#api_details').val('')
            show_success_message(response.success)
            $('#addAPIModal').modal('hide');
            get_all_api_list();
        })
        .fail(function (error) {
            show_error_message(error.responseJSON.error)
        });
}


function get_all_api_list() {
    const params = {
        api_role: $('#filter_api_role').val(),
        api_type: $('#filter_api_type').val(),
        api_link: $('#filter_api_link').val()
    }
    $.get('api/api_list', params)
        .done(function (data) {
            $('#tbody_api_list').empty();

            if (data.length > 0) {
                data.forEach(function (item) {
                    const row = `
                        <tr>
                            <td>${item.role_name}</td>
                            <td>${item.api}</td>
                            <td><span class="text-info fw-bold  fs-6">${item.type}</span></td>
                            <td>${item.created_at}</td>
                            <td class="text-end">
                                <button type="text" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#updateAPIModal" onclick="setUpdateAPI('${item.id}')"><i class="fas fa-edit text-sm"></i></button>
                                <button type="text" class="btn btn-sm btn-danger" onclick="deleteAPI('${item.id}')"><i class="fas fa-trash-alt text-sm"></i></button>
                            </td>
                        </tr>
                    `;
                    $('#tbody_api_list').append(row);
                });
            } else {
                const noDataRow = `
                    <tr>
                        <td colspan="5" class="text-center my-2">No data available</td>
                    </tr>
                `;
                $('#tbody_api_list').append(noDataRow);
            }
        })
        .fail(function (error) {
            show_error_message(error.responseJSON.error);
        });
}


function deleteAPI(api_id) {
    if (confirm('Are you sure you want to delete this api?')) {
        $.ajax({
            url: `api/delete_api?api_id=${api_id}`,
            type: 'DELETE',
            success: function(response) {
                show_success_message(response.success);
                get_all_api_list();
            },
            error: function(error) {
                show_error_message(error.responseJSON.error);
            }
        });
    }
}


function reset_api_filter(){
    $('#filter_api_role').val(null).trigger('change');
    $('#filter_api_link').val('');
    $('#filter_api_type').val('');
    get_all_api_list();
}

$('#btn_create_api').on('click', function(){
    commonModalAutocomplete($('#api_role_name'), $('#suggestionRoles'), $('#suggestionRoles').attr('id'));
})


function setUpdateAPI(api_id){
    commonModalAutocomplete($('#up_api_role_name'), $('#suggestionUpdateRoles'), $('#suggestionUpdateRoles').attr('id'));

    $.get(`api/update_api?api_id=${api_id}`,)
        .done(function (res) {
            $('#up_role_id').text(res.id);
            $('#up_role').text(res.role);
            $('#up_api_role_name').val(res.role);
            $('#update_api_type').val(res.type);
            $('#update_api_link_text').val(res.api);
            $('#update_api_details').val(res.details);
        })
        .fail(function (error) {
            show_error_message(error.responseJSON.error)
        });
}


function updateApiData() {
    const apiId = $('#up_role_id').text();
    var data = {
        role: $('#up_api_role_name').val(),
        type: $('#update_api_type').val(),
        api: $('#update_api_link_text').val(),
        details: $('#update_api_details').val()
    };

    $.ajax({
        url: 'api/update_api?api_id=' + apiId,
        type: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function(response) {
            show_success_message(response.success);
            $('#updateAPIModal').modal('hide');
            get_all_api_list();
        },
        error: function(error) {
            show_error_message(error.responseJSON.error);
        }
    });
}

