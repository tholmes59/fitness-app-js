$(() => {
    bindClickHandleers()
})

const bindClickHandleers = () => {
    $('#all-workouts').on('click', (e) => {
        e.preventDefault()
        console.log('test')
    })
}