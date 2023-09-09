import {Inject, Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {environment} from "../environments/environment";
import {map, Observable, Subject} from "rxjs";
import {Talk, Vote} from "./models";

@Injectable({providedIn:'root'})
export class ApiService {

  private url = environment.api_url

  private talks = new Subject<Talk[]>();
  talks$ = this.talks.asObservable();

  private talk = new Subject<Talk>();
  talk$ = this.talk.asObservable();

  private votes = new Subject<Vote[]>();
  votes$ = this.votes.asObservable();

  constructor(private http: HttpClient) {
  }

  getTalks() {
    this.http.get<Talk[]>(this.url + "/talks").subscribe(next => {
      this.talks.next(next)
    })
  }

  getTalk(id: string, error: () => void) {
    this.http.get<Talk>(this.url + "/talks/"+id).subscribe({
      next: n => this.talk.next(n),
      error: _ => error.call(this)
    })
  }

  getVotes(id: string) {
    this.http.get<Vote[]>(this.url + "/talks/" + id + "/votes").subscribe(next => {
      this.votes.next(next)
    })
  }

  putVote(id: string, value: number, completeCallback: () => void) {
    this.http.put(this.url + "/talks/" + id + "/votes", {value: value}).subscribe({
      complete: completeCallback
    })
  }
}
