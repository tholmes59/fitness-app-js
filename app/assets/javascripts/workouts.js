$(() => {
    bindClickHandlers()
})

const bindClickHandlers = () => {
    $('#all-workouts').on('click', (e) => {
        e.preventDefault()
        fetch('/workouts.json')
        .then(res => res.json())
        .then(workouts => {
            $('#app-container').html('<h1>Pick a Workout!</h1>')
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

    $(document).on("click", "#next-workout", function() {
        let id = $(this).attr("data-id")
        fetch(`workouts/${id}/next.json`)
        .then(res => res.json())
        .then(workout => {
            $('#app-container').html(' ')
                let newWorkoutShow = new Workout(workout)
                let showWorkoutHtml = newWorkoutShow.formatShow()
                $('#app-container').append(showWorkoutHtml).addClass('container workouts-show')
        })
    })

    $(document).on("click", "#previous-workout", function() {
        let id = $(this).attr("data-id")
        fetch(`workouts/${id}/previous.json`)
        .then(res => res.json())
        .then(workout => {
            $('#app-container').html(' ')
                let newWorkoutShow = new Workout(workout)
                let showWorkoutHtml = newWorkoutShow.formatShow()
                $('#app-container').append(showWorkoutHtml).addClass('container workouts-show')
        })
    })

    $(document).on("submit", "#workoutReviewForm", function(e) {
        e.preventDefault()
        console.log($(this).serialize())
        const values = $(this).serialize()
        let id = $("#workoutReviewForm").attr('data_id')
        $.post(`/workouts/${id}/reviews`, values).done(function(data) {
            // console.log(data)
            const newReview = new Review(data)
        })
            fetch(`/workouts/${id}.json`)
            .then(res => res.json())
            .then(workout => {
                $('#app-container').html(' ')
                    let newWorkoutShow = new Workout(workout)
                    let showWorkoutHtml = newWorkoutShow.formatShow()
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

    const workoutExercisesName = this.workout_exercise.map((exercise) => {
        return `
        <tr>
            <td>${exercise.exercise_name}</td>
            <td>${exercise.sets}</td>
            <td>${exercise.repetitions}</td>
        </tr>
        `;
    })
    // console.log(this.review)

    const reviewCount =  this.review.length
    // console.log(reviewCount)
        
    const totalReviews = () => {
        if (reviewCount === 0) {
          return "There are no reviews.";
        } else if (reviewCount === 1) {
          return "1 review";
        } else {
          return `${reviewCount} reviews`;
        }
    }
    // console.log(totalReviews())

    const ratingArray = this.review.map((review) => {
        return `${review.rating}`
    })
    
    const averageRating = () => {
        if (ratingArray !== undefined) {
        const ratingArrayNumber = ratingArray.map(Number);

        const avg = (ratingArrayNumber.reduce((acc, val) => acc + val)/ratingArrayNumber.length).toFixed(2)
        return `${avg}`
        } else {
            return ''
        }
    }

    const reviews = this.review.map((review) => {
        return `
            Rated a ${review.rating} by ${review.reviewer} on ${review.createdAt.toLocaleDateString()} - ${review.content}<br><br>
        `;
    })
    
    let showWorkoutHtml = 
    `
    <h1>${this.workout_name}</h1>
    <h4>Workout by: <a href="/users/${this.user.id}">${this.user.username}</a></h4>
    <h4>Average Rating: ${averageRating()}</h4>
    <h4>Summary:</h4>
        <p>${this.workout_description}</p><br>
    <h4>What exercises you will need to perform:</h4>
        <table>
        <tr>
            <th>Exercise</th>
            <th>Sets</th>
            <th>Repetitions</th>
        </tr>

        <tbody>
            ${workoutExercisesName.join('')}
        </tbody>
        
        </table><br>

    <h4>How to get the most out of it:</h4>
    <p>${this.workout_instructions}</p><br>

    <h4>Reviews:</h4>

       <p>${totalReviews()}</p>
       
        <div id="show-reviews">
            ${reviews.join('')}
        </div>

    <form id="workoutReviewForm" data_id="${this.id}">
        <label>Rating from 1-5:</label><br>
        <input min="0" max="5" type="number" name="review[rating]" id="review_rating"><br>
        <label>Review:</label><br>
        <textarea name="review[content]" id="review_content"></textarea><br><br>
        <input type="submit" name="commit" value="Create Review" class="btn btn-primary"><br><br>
    </form>

    <button data-id="${this.id}" id="previous-workout" class="btn btn-primary">Previous</button>
    <button data-id="${this.id}" id="next-workout" class="btn btn-primary">Next</button>
    `

    return showWorkoutHtml;
}

