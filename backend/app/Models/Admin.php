<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Admin extends Model
{
    protected $table = 'admins';

    protected $primaryKey = 'adminID';

    public $timestamps = false;

    protected $fillable = [
        'uID',
        'name',
        'password',
        'createdAt'
    ];

    // relationship: admin belongs to user
    public function user()
    {
        return $this->belongsTo(User::class, 'uID', 'id');
    }
}