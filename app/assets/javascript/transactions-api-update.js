document.addEventListener('turbo:load', () => {
    // console.log('Turbo load event triggered');
    change_category();
});

function change_category() {    
    document.querySelectorAll('.change-category').forEach(function(element) {
        element.addEventListener('change', function() {
            const transactionId = element.getAttribute('data');
            console.log(transactionId);
            const value = this.value;
            fetch(`/transactions/${transactionId}/api_update`, {
                method: 'PATCH',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ transaction: { category: value } }),
            })
            .then(response => response.json())
            .then(data => console.log('Success:', data))
            .catch((error) => {
                console.error('Error:', error);
            });
        });
    });
}