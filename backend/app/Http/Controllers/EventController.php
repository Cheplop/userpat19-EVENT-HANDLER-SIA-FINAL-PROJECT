<?php

namespace App\Http\Controllers;
use App\Http\Controllers\Controller;
use App\Models\Event;
use Illuminate\Http\Request;

class EventController extends Controller
{
    public function index() {
        return Event::all();
    }

    public function store(Request $request)
    {
        $request->validate([
            'eventTitle' => 'required|max:100',
            'eventDescription' => 'nullable',
            'eventDate' => 'required|date',
            'eventLocation' => 'required|max:100',
        ]);

        $event = Event::create([
            'eventTitle' => $request->eventTitle,
            'eventDescription' => $request->eventDescription,
            'eventDate' => $request->eventDate,
            'eventLocation' => $request->eventLocation,
            'createdAt' => now(),
            'updatedAt' => now(),
        ]);

        return response()->json([
            'message' => 'Event created successfully',
            'event' => $event
        ], 201);
    }

    public function update(Request $request, $id) {
        $event = Event::findOrFail($id);
        $event->update($request->all());
        return $event;
    }

    public function destroy($id)
    {
        $event = Event::find($id);

        if (!$event) {
        return response()->json([
            'message' => 'Event not found'
            ], 404);
        }

        $event->delete();

        return response()->json([
        'message' => 'Event deleted successfully'
        ]);
    }
}



