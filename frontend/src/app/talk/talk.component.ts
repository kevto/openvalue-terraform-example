import {Component, OnInit} from '@angular/core';
import {ApiService} from "../api.service";
import {Observable} from "rxjs";
import {Talk, Vote} from "../models";
import {ActivatedRoute, Router} from "@angular/router";

@Component({
  selector: 'talk',
  templateUrl: './talk.component.html',
  styleUrls: ['./talk.component.sass']
})
export class TalkComponent implements OnInit {

  talk: Talk | undefined
  score = 0
  validVotes = 0

  constructor(private api: ApiService, private route: ActivatedRoute, private router: Router) {
    api.votes$.subscribe(votes => {
      this.calculateScore(votes)
    })
  }

  ngOnInit() {
    this.route.paramMap.subscribe(params => {
      const foundId = params.get("id");
      if (foundId == undefined) {
        this.router.navigate(["/"])
        return
      }

      this.api.getTalk(foundId, () => this.router.navigate(["/"]));
      this.api.getVotes(foundId)
    })
  }

  calculateScore(votes: Vote[]) {
    var voteSum = 0
    var voteNotValid = 0
    votes.forEach(vote => {
      if (vote.value) voteSum += vote.value
      else voteNotValid++
    })

    const totalValidVotes = votes.length - voteNotValid
    if (totalValidVotes < 0) {
      this.validVotes = 0
      this.score = 0
    } else {
      this.validVotes = totalValidVotes
      this.score = voteSum / totalValidVotes
    }
  }
}
