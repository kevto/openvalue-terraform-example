import {Component, OnInit} from '@angular/core';
import {ApiService} from "../api.service";
import {Observable} from "rxjs";
import {Talk, Vote} from "../models";
import {ActivatedRoute, Router} from "@angular/router";
import {FormControl, FormGroup, Validators} from "@angular/forms";

@Component({
  selector: 'talk',
  templateUrl: './talk.component.html',
  styleUrls: ['./talk.component.sass']
})
export class TalkComponent implements OnInit {

  talkId: string | null = null
  talk: Talk | undefined
  score = 0
  validVotes = 0

  voteFormGroup: FormGroup = new FormGroup({
    vote: new FormControl('', Validators.required),
  });

  constructor(private api: ApiService, private route: ActivatedRoute, private router: Router) {
    api.talk$.subscribe(talk => this.talk = talk)
    api.votes$.subscribe(votes => {
      this.calculateScore(votes)
    })
  }

  ngOnInit() {
    this.route.paramMap.subscribe(params => {
      this.talkId = params.get("id");
      if (this.talkId == undefined) {
        this.router.navigate(["/"])
        return
      }

      this.api.getTalk(this.talkId, () => this.router.navigate(["/"]));
      this.api.getVotes(this.talkId)
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
    if (totalValidVotes <= 0) {
      this.validVotes = 0
      this.score = 0
    } else {
      this.validVotes = totalValidVotes
      this.score = voteSum / totalValidVotes
    }
  }

  vote() {
    this.api.putVote(this.talkId!!, this.voteFormGroup.get("vote")?.value,
        () => this.api.getVotes(this.talkId!!))
  }
}
