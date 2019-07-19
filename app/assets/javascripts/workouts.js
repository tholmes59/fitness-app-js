$(() => {
    bindClickHandlers()
})

const bindClickHandlers = () => {
    $('#all-workouts').on('click', (e) => {
        e.preventDefault()
        fetch('/workouts.json')
    })
}