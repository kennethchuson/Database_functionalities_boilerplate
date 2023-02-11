
/*


In MongoDB, there is no equivalent for the ON DELETE CASCADE foreign key constraint, so you would need to implement this behavior in your application logic when deleting a user document.


*/

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const userSchema = new Schema({
    first_name: {
        type: String,
        required: true
    },
    last_name: {
        type: String,
        required: true
    },
    username: {
        type: String,
        required: true,
        unique: true
    },
    created_at: {
        type: Date,
        default: Date.now
    },
    password: {
        type: String,
        required: true
    }
});

const User = mongoose.model('User', userSchema);

const postSchema = new Schema({
    user_id: {
        type: Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    media: {
        type: Buffer
    },
    description: {
        type: String
    },
    created_at: {
        type: Date,
        default: Date.now
    }
});

const Post = mongoose.model('Post', postSchema);

module.exports = { User, Post };






db.createCollection("users");

db.users.insert({
    first_name: "",
    last_name: "",
    username: "",
    created_at: new Date(),
    password: ""
});

db.users.createIndex({ username: 1 }, { unique: true });


db.createCollection("posts");

db.posts.insert({
    user_id: ObjectId(""),
    media: BinData(0, ""),
    description: "",
    created_at: new Date()
});

db.posts.createIndex({ user_id: 1 });


