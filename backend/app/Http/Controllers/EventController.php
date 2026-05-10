<?php


use App\Models\Event;
use Illuminate\Http\Request;

class EventController extends Controller
{
    public function index() {
        return Event::all();
    }

    public function store(Request $request) {
        return Event::create($request->all());
    }

    public function update(Request $request, $id) {
        $event = Event::findOrFail($id);
        $event->update($request->all());
        return $event;
    }

    public function destroy($id) {
        return Event::destroy($id);
    }
}



