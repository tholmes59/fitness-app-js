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
            // console.log(workout)
            $('#app-container').html(' ')
                let newWorkoutShow = new Workout(workout)
                // console.log(newWorkoutShow)
                let showWorkoutHtml = newWorkoutShow.formatShow()
                // console.log(workoutHtml)
                $('#app-container').append(showWorkoutHtml).addClass('container workouts-show')
        })
    })
}


function Workout(workout) {
    this.id = workout.id;
    this.workout_name = workout.workout_name;
    this.workout_description = workout.workout_description;
    this.workout_instructions = workout.workout_instructions;
    this.exercise = workout.exercises.map(json => new Exercise(json));
    this.workout_exercise = workout.workout_exercises.map(json => new WorkoutExercise(json));
    this.createdAt = new Date(workout.created_at);
    this.user = new User(workout.user);
    this.review = workout.reviews.map(json => new Review(json));
}

Workout.prototype.formatIndex = function() {
    let workoutHtml = `
    <a href="/workouts/${this.id}" data-id="${this.id}" class="show-link">${this.workout_name}</a><br>
    ${this.workout_description}<br>
    by: <a href="/users/${this.user.id}">${this.user.username}</a> on ${this.createdAt.toLocaleDateString()}<br><br>
    `
    return workoutHtml;
}

Workout.prototype.formatShow = function() {
    // const workoutExercises = exercise.map((exercise) => {
    //     return `
    //     <tr>
    //         <td>${exercise.exercise_name}</td>
    //         <td>${exercise.sets}</td>
    //         <td>${exercise.repetitions}</td>
    //     </tr>
    //     `;
    // })
    let showWorkoutHtml = `
    <h1>${this.workout_name}</h1>
    <h4>Workout by: <a href="/users/${this.user.id}">${this.user.username}</a></h4>
    <h4>Summary</h4>
        <p>${this.workout_description}</p>
    <h4>What exercises you will need to perform:</h4>
        <table>
        <tr>
            <th>Exercise</th>
            <th>Sets</th>
            <th>Repetitions</th>
        </tr>

        <tr>
            <td>${this.exercise.exercise_name}</td>
            <td>${this.workout_exercise.sets}</td>
            <td>${this.workout_exercise.repetitions}</td>
        </tr>

        
        </table><br>

    <h4>How to get the most out of it:</h4>
    <p>${this.workout_instructions}</p>
    `
    console.log(this)
    return showWorkoutHtml;
}

