const db = require('../../db/index');

const getAllUsers = async (req, res, next) =>{
    try{
        let allUsers = await db.any('SELECT * FROM Users');
        res.status(200).json({
            status: 'success',
            message: 'retrieves all users',
            payload: allUsers
        })
    }catch(error){
        res.status(400).json({
            status: 'error',
            message: 'could not retrieve all users'
        })
    }
}

const getSingleUser = async (req, res, next) =>{
    try{
        let singleUser = await db.one('SELECT * FROM Users WHERE id= $1', [req.params.id]);
        res.status(200).json({
            status: 'success',
            message: 'retrieves single user by ID',
            payload: singleUser
        })
    }catch(error){
        res.status(400).json({
            status: 'error',
            message: 'could not get single user by ID',
        })
    }
}
const getSingleUserByEmail = async (req, res, next) =>{
    try{
        let singleUser = await db.one('SELECT * FROM Users WHERE email= $1', [req.params.email]);
        res.status(200).json({
            status: 'success',
            message: 'retrieves single user by Email',
            payload: singleUser
        })
    }catch(error){
        res.status(400).json({
            status: 'error',
            message: 'could not get single user by Email',
        })
    }
}

const getNewUser = async (req, res, next) =>{
    try{
        let newUser = await db.one(`INSERT INTO Users (username, password, bio, profilePic, email) VALUES('${req.body.username}', '${req.body.password}', '${req.body.bio}', '${req.body.profilePic}','${req.body.email}') RETURNING *`)
        res.status(200).json({
            status: 'success',
            message: 'created a new user',
            payload: newUser
        })

    }catch(error){
        res.json({
            status: error.detail,
            message: 'could not created the new user'
        })
    }
}

const updateSingleUser = async (req, res, next) =>{
    try{
        let updateUser = await db.one(`UPDATE Users SET profilePic = $1 WHERE id = ${req.params.id} RETURNING *`,[req.body.profilePic])
        res.status(200).json({
            status: 'success',
            message: 'updated User',
            payload: updateUser
        })
    }catch(error){
        console.log(error)
        res.status(400).json({
            status: 'error',
            message: 'could not update user'
        })
    }
}

const deleteSingleUser = async (req, res, next) =>{
    try{
        let deleteUser = await db.one('DELETE FROM Users WHERE id = $1 RETURNING *', [req.params.id]);
        res.status(200).json({
            status: 'success',
            message: 'deleted user',
            payload: deleteUser
        })
    }catch(error){
        res.status(400).json({
            status: 'error',
            message: 'could not delete user'
        })
    }
}
module.exports = {getAllUsers, getSingleUser, getNewUser, deleteSingleUser, updateSingleUser,getSingleUserByEmail}