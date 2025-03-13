document.addEventListener('turbo:load', () => {
    // console.log('Turbo load event triggered');
    change_category();
    change_frequency();
    change_type_of_expense();
});

function change_category() {    
    document.querySelectorAll('.change-category').forEach(function(element) {
        element.addEventListener('change', function() {
            const transactionId = element.getAttribute('data');
            // console.log(transactionId);
            const value = this.value;
            fetch(`/transactions/${transactionId}/api_update`, {
                method: 'PATCH',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ transaction: { category_id: value } }),
            })
            .then(response => response.json())
            .then(data => console.log('Success:', data))
            .catch((error) => {
                console.error('Error:', error);
            });
        });
    });
}

function change_frequency() {    
    document.querySelectorAll('.change-frequency').forEach(function(element) {
        element.addEventListener('change', function() {
            const transactionId = element.getAttribute('data');
            console.log(transactionId);
            const value = this.value;
            fetch(`/transactions/${transactionId}/api_update`, {
                method: 'PATCH',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ transaction: { frequency: value } }),
            })
            .then(response => response.json())
            .then(data => console.log('Success:', data))
            .catch((error) => {
                console.error('Error:', error);
            });
        });
    });
}

function change_type_of_expense() {    
    document.querySelectorAll('.change-type-of-expense').forEach(function(element) {
        element.addEventListener('change', function() {
            const categoryId = element.getAttribute('data');
            console.log(categoryId);
            const value = this.value;
            fetch(`/categories/${categoryId}.json`, {
                method: 'PATCH',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ category: { type_of_expense: value } }),
            })
            .then(response => response.json())
            .then(data => console.log('Success:', data))
            .catch((error) => {
                console.error('Error:', error);
            });
        });
    });
}