
/*


Note: MongoDB does not have a concept of "auto-incrementing primary key" like SQL databases do, so the id field would be replaced by MongoDB's own unique _id field. Also, MongoDB does not have a concept of foreign keys and unique constraints, so you'll have to enforce these constraints in your application code. Finally, MongoDB does not have a concept of triggers, so you'll have to enforce the limit on the number of tags for a post in your application code.


*/



db.createCollection("users")
db.users.insert({
    first_name: "string",
    last_name: "string",
    username: "string",
    password: "string",
    created_at: new Date()
})

db.createCollection("posts")
db.posts.insert({
    user_id: "ObjectId",
    media: "binary",
    description: "string",
    created_at: new Date()
})

db.createCollection("followings")
db.followings.insert({
    follower_id: "ObjectId",
    followee_id: "ObjectId",
    created_at: new Date()
})

db.createCollection("comments")
db.comments.insert({
    user_id: "ObjectId",
    post_id: "ObjectId",
    comment: "string",
    created_at: new Date()
})

db.createCollection("replies")
db.replies.insert({
    user_id: "ObjectId",
    comment_id: "ObjectId",
    reply: "string",
    created_at: new Date()
})

db.createCollection("tags")
db.tags.insert({
    name: "string",
    link: "string",
    color: "string"
})

db.createCollection("post_tags")
db.post_tags.insert({
    post_id: "ObjectId",
    tag_id: "ObjectId"
})
