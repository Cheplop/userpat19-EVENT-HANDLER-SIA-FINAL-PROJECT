<?php

namespace App\Http\Controllers;
use App\Http\Controllers\Controller;
use App\Models\Event;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Schema;

class EventController extends Controller
{
    public function index()
    {
        return Event::all();
    }

    public function store(Request $request)
    {
        $request->validate([
            'eventTitle' => 'required|max:100',
            'title' => 'sometimes|required|max:100',
            'eventDescription' => 'nullable',
            'description' => 'sometimes|nullable',
            'eventDate' => 'required|date',
            'date' => 'sometimes|required|date',
            'eventLocation' => 'required|max:100',
            'location' => 'sometimes|required|max:100',
            'capacity' => 'sometimes|integer|min:0',
        ]);

        $eventData = [
            'eventTitle' => $request->input('eventTitle', $request->input('title')),
            'eventDescription' => $request->input('eventDescription', $request->input('description')),
            'eventDate' => $request->input('eventDate', $request->input('date')),
            'eventLocation' => $request->input('eventLocation', $request->input('location')),
        ];

        if (Schema::hasColumn('events', 'capacity')) {
            $eventData['capacity'] = $request->input('capacity', 0);
        }

        $event = Event::create($eventData);

        return response()->json([
            'message' => 'Event created successfully',
            'event' => $event
        ], 201);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'eventTitle' => 'sometimes|required|max:100',
            'title' => 'sometimes|required|max:100',
            'eventDescription' => 'nullable',
            'description' => 'sometimes|nullable',
            'eventDate' => 'sometimes|required|date',
            'date' => 'sometimes|required|date',
            'eventLocation' => 'sometimes|required|max:100',
            'location' => 'sometimes|required|max:100',
            'capacity' => 'sometimes|integer|min:0',
        ]);

        $event = Event::findOrFail($id);

        $data = [
            'eventTitle' => $request->input('eventTitle', $request->input('title', $event->eventTitle)),
            'eventDescription' => $request->input('eventDescription', $request->input('description', $event->eventDescription)),
            'eventDate' => $request->input('eventDate', $request->input('date', $event->eventDate)),
            'eventLocation' => $request->input('eventLocation', $request->input('location', $event->eventLocation)),
        ];

        if (Schema::hasColumn('events', 'capacity')) {
            $data['capacity'] = $request->input('capacity', $request->input('eventCapacity', $event->capacity ?? 0));
        }

        $event->update($data);

        return response()->json([
            'message' => 'Event updated successfully',
            'event' => $event
        ], 200);
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



