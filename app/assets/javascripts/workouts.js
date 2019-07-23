$(() => {
    bindClickHandlers()
})

const bindClickHandlers = () => {
    $('#all-workouts').on('click', (e) => {
        e.preventDefault()
        fetch('/workouts.json')
        .then(res => res.json())
        .then(workouts => {
            $('#app-container').html(' ')
            workouts.forEach((workout) => {
                let newWorkout = new Workout(workout)
                let workoutHtml = newWorkout.formatIndex()
                // console.log(workoutHtml)
                $('#app-container').append(workoutHtml).addClass('container workouts-index')
            })
        })
    })
    $(document).on('click', ".show-link", function(e) {
        e.preventDefault()
        let id = $(this).attr('data-id')
        fetch(`/workouts/${id}.json`)
        .then(res => res.json())
        .then(workout => {
            console.log(workout)
            $('#app-container').html(' ')
                let newWorkout = new Workout(workout)
                let workoutHtml = newWorkout.formatShow()
                console.log(workoutHtml)
                $('#app-container').append(workoutHtml).addClass('container workouts-show')
        })
    })
}


function Workout(workout) {
    this.id = workout.id;
    this.workout_name = workout.workout_name;
    this.workout_description = workout.workout_description;
    this.workout_instructions = workout.workout_instructions;
    this.exercise = workout.exercises.map(json => new Exercise(json));
    this.createdAt = new Date(workout.created_at);
    this.user = new User(workout.user);
    this.review = workout.reviews.map(json => new Review(json));
}

Workout.prototype.formatIndex = function() {
    let workoutHtml = `
    <a href="/workouts/${this.id}" data-id="${this.id}" class="show-link">${this.workout_name}</a><br>
    ${this.workout_description}<br>
    by: ${this.user.username} on ${this.createdAt.toLocaleDateString()}<br><br>
    `
    return workoutHtml;
}

Workout.prototype.formatShow = function() {
    let workoutHtml = `
    <h1>${this.workout_name}</h1>
    `
    return workoutHtml;
}