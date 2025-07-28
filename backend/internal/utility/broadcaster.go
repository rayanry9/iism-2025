package utility

import (
	"log/slog"
	"sync"
)

var PoolBroadcasterInstance PoolBroadcaster = PoolBroadcaster{}

type PoolBroadcaster struct {
	subscribers []chan PoolTeamUpdateBroadcastData // Sport Id
	lock        sync.Mutex
}

type PoolTeamUpdateBroadcastData struct {
	InstituteName string `json:"instituteName"`
	InstituteId   int    `json:"instituteId"`
	PoolTeamId    int    `json:"poolTeamId"`
	Upcoming      bool   `json:"upcoming"`
}

func (p *PoolBroadcaster) Subscribe() chan PoolTeamUpdateBroadcastData {
	channel := make(chan PoolTeamUpdateBroadcastData, 10)
	p.lock.Lock()
	p.subscribers = append(p.subscribers, channel)
	p.lock.Unlock()
	return channel
}

func (p *PoolBroadcaster) Broadcast(data PoolTeamUpdateBroadcastData) {
	var newSubscribers []chan PoolTeamUpdateBroadcastData
	p.lock.Lock()
	for _, sub := range p.subscribers {
		if safeSend(sub, data) {
			newSubscribers = append(newSubscribers, sub)
		}
	}
	p.subscribers = newSubscribers
	slog.Info("Pool Broadcaster", "length", len(p.subscribers))
	p.lock.Unlock()
}

func safeSend(ch chan PoolTeamUpdateBroadcastData, val PoolTeamUpdateBroadcastData) (ok bool) {
	defer func() {
		if r := recover(); r != nil {
			ok = false
		}
	}()
	ch <- val
	return true
}
