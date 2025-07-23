package utility

import (
	"log/slog"
	"sync"
)

var PoolBroadcasterInstance PoolBroadcaster = PoolBroadcaster{}

type PoolBroadcaster struct {
	subscribers []chan int // Sport Id
	lock        sync.Mutex
}

func (p *PoolBroadcaster) Subscribe() chan int {
	channel := make(chan int, 10)
	p.lock.Lock()
	p.subscribers = append(p.subscribers, channel)
	p.lock.Unlock()
	return channel
}

func (p *PoolBroadcaster) Broadcast(sportId int) {
	var newSubscribers []chan int
	p.lock.Lock()
	for _, sub := range p.subscribers {
		if safeSend(sub, sportId) {
			newSubscribers = append(newSubscribers, sub)
		}
	}
	p.subscribers = newSubscribers
	slog.Info("Pool Broadcaster", "length", len(p.subscribers))
	p.lock.Unlock()
}

func safeSend(ch chan int, val int) (ok bool) {
	defer func() {
		if r := recover(); r != nil {
			ok = false
		}
	}()
	ch <- val
	return true
}
